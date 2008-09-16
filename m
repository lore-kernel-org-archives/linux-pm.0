From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Tue, 16 Sep 2008 10:02:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809161000410.3875@apollo.tec.linutronix.de>
References: <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz> <20080914173536.GA1687@elf.ucw.cz> <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de>
 <20080914181228.GA18934@elf.ucw.cz> <alpine.LFD.1.10.0809141214110.5283@apollo.tec.linutronix.de> <20080915091925.GB1787@elf.ucw.cz> <alpine.LFD.1.10.0809150704420.5283@apollo.tec.linutronix.de> <20080915192600.GA1627@elf.ucw.cz> <20080915195951.GA1651@elf.ucw.cz>
 <alpine.LFD.1.10.0809160715120.3606@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757129AbYIPRDU@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0809160715120.3606@apollo.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Sep 2008, Thomas Gleixner wrote:
> On Mon, 15 Sep 2008, Pavel Machek wrote:
> > > cg-seek here, and problem is back. Good. I can get the

Does the patch below fix it ?

Thanks,

	tglx
----
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 1876b52..eb8736f 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -69,6 +69,9 @@ void clockevents_set_mode(struct clock_event_device *dev,
 		dev->set_mode(mode, dev);
 		dev->mode = mode;
 	}
+
+	if (mode == CLOCK_EVT_MODE_SHUTDOWN)
+		dev->next_event.tv64 = KTIME_MAX;
 }
 
 /**
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 2f5a382..6b0b230 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -434,6 +434,19 @@ again:
 }
 
 /*
+ * We shutdown the device which will stop anyway, but we keep the
+ * next_event untouched as it carries the information when we
+ * broadcast.
+ */
+static void tick_broadcast_shutdown_device(struct clock_event_device *dev)
+{
+	if (dev->mode != CLOCK_EVT_MODE_SHUTDOWN) {
+		dev->set_mode(CLOCK_EVT_MODE_SHUTDOWN, dev);
+		dev->mode = CLOCK_EVT_MODE_SHUTDOWN;
+	}
+}
+
+/*
  * Powerstate information: The system enters/leaves a state, where
  * affected devices might stop
  */
@@ -464,7 +477,7 @@ void tick_broadcast_oneshot_control(unsigned long reason)
 	if (reason == CLOCK_EVT_NOTIFY_BROADCAST_ENTER) {
 		if (!cpu_isset(cpu, tick_broadcast_oneshot_mask)) {
 			cpu_set(cpu, tick_broadcast_oneshot_mask);
-			clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
+			tick_broadcast_shutdown_device(dev);
 			if (dev->next_event.tv64 < bc->next_event.tv64)
 				tick_broadcast_set_event(dev->next_event, 1);
 		}

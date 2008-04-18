From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-mm1: not looking good
Date: Fri, 18 Apr 2008 00:53:23 -0700
Message-ID: <20080418005323.7c015c42.akpm__13465.120472438$1208505326$gmane$org@linux-foundation.org>
References: <20080417160331.b4729f0c.akpm@linux-foundation.org>
	<20080418005034.6e4dd9e7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418005034.6e4dd9e7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 18 Apr 2008 00:50:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> dmesg: http://userweb.kernel.org/~akpm/x.txt
> config: http://userweb.kernel.org/~akpm/config-t61p.txt

oop, there's more:


sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
firewire_core: created device fw0: GUID 00016c2000174bad, S400
PM: Device usb4 failed to restore: error -113
eth0: Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
eth0: 10/100 speed: disabling TSO
PM: Device usb5 failed to restore: error -113
PM: Device usb7 failed to restore: error -113
sd 0:0:0:0: [sda] Starting disk
PM: Image restored successfully.
Restarting tasks ... done.
PM: Basic memory bitmaps freed

Those USB restore failures are new.  They're similar to the ones on the
doesnt-resume-properly-any-more Vaio.  They came out from the machine's
second (successful) resume-from-disk.

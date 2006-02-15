From: Pavel Machek <pavel@ucw.cz>
Subject: Re: what handles disk drive(s) shutdown?
Date: Thu, 16 Feb 2006 00:30:06 +0100
Message-ID: <20060215233006.GA3490@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
	<Pine.LNX.4.58.0602101457460.23838@shark.he.net>
	<20060210230633.GB1947@elf.ucw.cz>
	<200602102150.38832.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91453836314376313=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602102150.38832.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============91453836314376313==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > void kernel_shutdown_prepare(enum system_states state)
> > {
> >         notifier_call_chain(&reboot_notifier_list,
> >                 (state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
> >         system_state = state;
> >         device_shutdown();
> > }
> > 
> > device_shutdown() should do it, AFAICT.
> > 
> > If you want to listen to such event, you should just register your
> > driver with sysfs and implement .suspend() method. But I believe PATA
> > does that already...
> 
> You mean .shutdown() method, not .suspend(), right?
yep, sorry.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============91453836314376313==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91453836314376313==--

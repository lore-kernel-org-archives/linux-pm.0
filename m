From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: what handles disk drive(s) shutdown?
Date: Fri, 10 Feb 2006 21:50:38 -0500
Message-ID: <200602102150.38832.dtor_core@ameritech.net>
References: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
	<Pine.LNX.4.58.0602101457460.23838@shark.he.net>
	<20060210230633.GB1947@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060210230633.GB1947@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 10 February 2006 18:06, Pavel Machek wrote:
> 
> void kernel_shutdown_prepare(enum system_states state)
> {
>         notifier_call_chain(&reboot_notifier_list,
>                 (state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
>         system_state = state;
>         device_shutdown();
> }
> 
> device_shutdown() should do it, AFAICT.
> 
> If you want to listen to such event, you should just register your
> driver with sysfs and implement .suspend() method. But I believe PATA
> does that already...

You mean .shutdown() method, not .suspend(), right?

-- 
Dmitry

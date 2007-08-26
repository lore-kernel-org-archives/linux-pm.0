From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PROBLEM: Suspend corrupts bios clock since 2.6.21
Date: Mon, 27 Aug 2007 00:45:08 +0200
Message-ID: <200708270045.09050.rjw__7950.24626791037$1188167742$gmane$org@sisk.pl>
References: <fa.Hms7k1HwOwCbv7cPqUWGLhT5uyk@ifi.uio.no>
	<46D1D6D1.5040203@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46D1D6D1.5040203@shaw.ca>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-pm@lists.linux-foundation.org, pavel@suse.cz, Andreas Steffan <a.steffan@deas-online.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 26 August 2007 21:38, Robert Hancock wrote:
> Andreas Steffan wrote:
> > Hallo everybody,
> > 
> > I am running fedora core 7 on my Dell latitude D810 notebook (BIOS
> > rev A05).
> > 
> > Since 2.6.21 I found that suspending (to disk and to ram) corrupts
> > the bios clock most of the time (not always). The corruption is
> > happening during suspend. When I enter the system bios right after
> > I switch the system back on, I find the bios clock is set to a time
> > far in the future (many years). I guess that problem is related to
> > the clock changes that where introduced with 2.6.21.
> > 
> > Please let me know if you want me to provide further information to
> > get this problem fixed.
> > 
> > If there is a known quirk to work around this problem, I would
> > really appreciate a hint.
> > 
> > PS: I have not yet tried 2.6.22.4-65.fc7, but the latest 2.6.22 kernel
> > before showed the same behaviour for me.
> 
> Please check if PM_TRACE is enabled in your kernel configuration. It 
> will do this intentionally.

Yes, but only if you have "1" in /sys/power/pm_trace ...

Greetings,
Rafael

From: Dave Jones <davej@redhat.com>
Subject: Re: suspending to disk on FC6 not working
Date: Sat, 30 Sep 2006 23:21:35 -0400
Message-ID: <20061001032135.GB21796@redhat.com>
References: <EB12A50964762B4D8111D55B764A8454ABBB3D@scsmsx413.amr.corp.intel.com>
	<1159670982.3714.3.camel@soncomputer>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1159670982.3714.3.camel@soncomputer>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 30, 2006 at 10:49:42PM -0400, Louis Garcia wrote:
 > On Fri, 2006-09-29 at 15:55 -0700, Pallipadi, Venkatesh wrote:
 > > That's it.. This issue seems to be a side effect of that patch...
 > > =

 > > Louis: After normal boot of 2.6.18, if you are not seeing the directory
 > > /sys/devices/system/cpu/cpu0/cpufreq
 > > =

 > > Then try reverting this patch
 > > http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git=
;a=3Dc
 > > ommit;h=3D911cb74bb9e77e40749abc2fca6fe74d87d940f3
 > > =

 > > and then check whether the suspend resume issue goes away. =

 > > =

 > > Thanks,
 > > Venki
 > =

 > I reverted this patch and my suspend issue is gone. Though the
 > directory /sys/devices/system/cpu/cpu0/cpufreq is non existent, with or
 > without this patch.

Ok, I've backed that out in cpufreq.git, it'll go along to Linus soon.
If you build acpi-cpufreq as a module, and you modprobe acpi-cpufreq,
does it fail silently ? Or does it revert us back to the behaviour
where it's noisy again?

	Dave

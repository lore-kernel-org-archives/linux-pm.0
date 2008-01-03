From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [patch] hibernation: utilize ACPI hardware
	signature
Date: Thu, 3 Jan 2008 17:58:02 +0100
Message-ID: <200801031758.03056.rjw__17987.9066920423$1199379549$gmane$org@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801022301.45706.rjw@sisk.pl>
	<477C9D51.5000604@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <477C9D51.5000604@nigel.suspend2.net>
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
To: nigel@nigel.suspend2.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 of January 2008, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> >> I suppose we can always disable this when we start to support hardware
> >> changing over hibernate (I have ideas in this direction - memory cold
> >> plugging, for a start).
> > 
> > Well, if we support such features, we won't be following ACPI any more.
> 
> Mmm. Apparently I'm not as focused on specs as you :).
> 
> I was starting to think through whether it could make for a new and much
> faster was to boot live cds - something along the lines of complete
> redetection of hardware and memory cold plugging. Of course it's only in
> the 'I wonder if this would be possible' stage at the mo, but seemed at
> least feasible - keep the e820 tables from boot, make _init routines not
> get thrown away and do something like the kexec device shutdown etc
> around an atomic restore.
> 
> I know there'd be limitations, but perhaps worth thinking about...

Well, what if the new e820 map is incompatible with the old one?

Rafael

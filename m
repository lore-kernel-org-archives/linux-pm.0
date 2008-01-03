From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: [patch] hibernation: utilize ACPI hardware
	signature
Date: Thu, 03 Jan 2008 19:31:13 +1100
Message-ID: <477C9D51.5000604__35125.0578569763$1199349401$gmane$org@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801021505.39789.rjw@sisk.pl>
	<477C019D.1070001@nigel.suspend2.net>
	<200801022301.45706.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801022301.45706.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
>> I suppose we can always disable this when we start to support hardware
>> changing over hibernate (I have ideas in this direction - memory cold
>> plugging, for a start).
> 
> Well, if we support such features, we won't be following ACPI any more.

Mmm. Apparently I'm not as focused on specs as you :).

I was starting to think through whether it could make for a new and much
faster was to boot live cds - something along the lines of complete
redetection of hardware and memory cold plugging. Of course it's only in
the 'I wonder if this would be possible' stage at the mo, but seemed at
least feasible - keep the e820 tables from boot, make _init routines not
get thrown away and do something like the kexec device shutdown etc
around an atomic restore.

I know there'd be limitations, but perhaps worth thinking about...

Nigel

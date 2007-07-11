From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 02:59:48 +0100
Message-ID: <20070711015948.GA30659__38731.7374036231$1184119258$gmane$org@srcf.ucam.org>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707111053.36590.nigel@nigel.suspend2.net>
	<20070711012301.GA30596@srcf.ucam.org>
	<200707111139.38667.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707111139.38667.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, nigel@suspend2.net, Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 11, 2007 at 11:39:37AM +1000, Nigel Cunningham wrote:

> Yeah, that is a bit confusing. At the moment, I'm doing the suspend to ram 
> platform dependent preparation and cleanup in this scenario. That's 
> definitely the right thing to do in the case where we write an image, then 
> suspend to ram, wake and continue working without running running out of 
> battery (writing the image is redundant in that case). Where we end up 
> properly powering down after suspending to ram, I believe we don't run the 
> pm_ops->finish after doing the atomic restore when resuming the image.

I'm not convinced this can work terribly well. It's not unlikely that 
hardware will need different state stored over different types of 
suspend. Can you separate out the saving of kernel memory and userspace 
memory, then resume/suspend/save the new kernel state without touching 
the userspace state?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

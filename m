From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 16:00:42 +0100
Message-ID: <20070705150042.GA23647__44213.4365592667$1183647968$gmane$org@srcf.ucam.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051528.34754.oliver@neukum.org>
	<20070705134632.GA22177@srcf.ucam.org>
	<200707051609.25887.rjw@sisk.pl>
	<20070705142318.GA22598@srcf.ucam.org>
	<2c0942db0707050746v2b8cdc9ew2c4656736b52895d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2c0942db0707050746v2b8cdc9ew2c4656736b52895d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2007 at 07:46:01AM -0700, Ray Lee wrote:

> Hmm, careful. There are a bunch of people who use suspend2 exactly
> because it saves and restores the page cache, leaving the system in a
> usable state without waiting for the universe to swap back in from
> disk. It makes a big difference on older laptops with slow drives.
> While the other advantages you list for process cryogenics are pretty
> neat, let's remember that the 99% use case for STD is laptops.

Saving the processes means that you're implicitly saving the interesting 
chunks of the page cache. Removing the need for the atomic copy saves 
you from pushing a pile of stuff out to swap in the first place.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

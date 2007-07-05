From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 07:46:01 -0700
Message-ID: <2c0942db0707050746v2b8cdc9ew2c4656736b52895d__20322.3989498385$1183646886$gmane$org@mail.gmail.com>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051528.34754.oliver@neukum.org>
	<20070705134632.GA22177@srcf.ucam.org>
	<200707051609.25887.rjw@sisk.pl>
	<20070705142318.GA22598@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705142318.GA22598@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 7/5/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, Jul 05, 2007 at 04:09:24PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 5 July 2007 15:46, Matthew Garrett wrote:
> > > I have a model for STD that avoids the need to freeze the entirity of
> > > userspace, but I need to find some more time to flesh it out.
> >
> > You can just describe it, as far as I'm concerned. :-)
>
> The basic model is that nobody's really described a use-case where we
> actually care about restoring system state. What people want is to be
> able to restore application state.

Hmm, careful. There are a bunch of people who use suspend2 exactly
because it saves and restores the page cache, leaving the system in a
usable state without waiting for the universe to swap back in from
disk. It makes a big difference on older laptops with slow drives.
While the other advantages you list for process cryogenics are pretty
neat, let's remember that the 99% use case for STD is laptops.

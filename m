From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 01:34:24 +0100
Message-ID: <20070704003424.GA30958__28915.1205019609$1183509560$gmane$org@srcf.ucam.org>
References: <fa.ftLWBLCc+XqdYjiuxoPg+qyuUOE@ifi.uio.no>
	<fa.Oxrm8HYXTOF4jv5LrTjEe16lCE0@ifi.uio.no>
	<fa.d3GOse+YbAb42uYwLymWkJiH9Fw@ifi.uio.no>
	<468AE700.7080102@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <468AE700.7080102@shaw.ca>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 06:17:04PM -0600, Robert Hancock wrote:
> Matthew Garrett wrote:
> >Leave the process blocked and defer any i/o until after resume. Why does 
> >it need to be any more complicated than that?
> 
> It gets complicated when this has to be added and TESTED in EVERY 
> driver. The implied contract for drivers previously was that their 
> device would not get accessed after it was suspended until it had been 
> resumed first. This proposed change violates that.

No, that's only ever been true for ACPI systems. It's never been true 
elsewhere, and it won't be true for anything implementing any sort of 
runtime power management.

> I don't think this sort of handling is something that individual drivers 
> should have to deal with (at least not ones that are part of a framework 
> like USB, libata, etc.)

I'd agree there. Driver midlayers (where they exist) are the appropriate 
place to handle this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

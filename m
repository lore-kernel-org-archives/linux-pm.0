From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 12:06:09 -0400
Message-ID: <87wsxeu972.fsf__48796.1764367812$1183651659$gmane$org@jbms.ath.cx>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051528.34754.oliver@neukum.org>
	<20070705134632.GA22177@srcf.ucam.org> <200707051609.25887.rjw@sisk.pl>
	<20070705142318.GA22598@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705142318.GA22598@srcf.ucam.org> (Matthew Garrett's message
	of "Thu\, 5 Jul 2007 15\:23\:18 +0100")
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

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> On Thu, Jul 05, 2007 at 04:09:24PM +0200, Rafael J. Wysocki wrote:
>> On Thursday, 5 July 2007 15:46, Matthew Garrett wrote:
>> > I have a model for STD that avoids the need to freeze the entirity of 
>> > userspace, but I need to find some more time to flesh it out.
>> 
>> You can just describe it, as far as I'm concerned. :-)

[snip: new hibernate idea]

I think my kexec-based hibernate idea is simpler and more feasible than
this approach, and also avoids the freezer.

-- 
Jeremy Maitin-Shepard

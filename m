From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 15:14:36 +0100
Message-ID: <20090820141436.GA3722__30724.0847069354$1250777837$gmane$org@srcf.ucam.org>
References: <20090820030423.GA26357@sli10-desk.sh.intel.com>
	<Pine.LNX.4.44L0.0908201004100.3048-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908201004100.3048-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 20, 2009 at 10:11:19AM -0400, Alan Stern wrote:

> How is the wakeup event received?  Maybe for this one type of device a 
> PCI quirk will solve the problem.

Pretty much the same as PME events on PCI - a GPE is generated, an SCI 
raised, the ACPI interpreter executes the code that's in the ACPI 
tables, that generates a notification event on the appropriate UHCI 
device, we live happily ever after.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

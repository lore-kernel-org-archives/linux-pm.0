From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Fri, 19 Dec 2008 10:09:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812191005310.2453-100000__8964.77104765854$1229699533$gmane$org@iolanthe.rowland.org>
References: <1229668453.562.92.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1229668453.562.92.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 19 Dec 2008, Zhang Rui wrote:

> device parallel resume support for PCI devices

There are some PCI devices which won't work right if they are resumed
in parallel.  The example I have in mind is a USB host controller
device with both a high-speed EHCI controller function and some
companion low/full-speed UHCI or OHCI controller functions.  The EHCI
driver relies on the fact that the EHCI controller has a higher
function number and therefore is resumed _after_ the companion
controllers.

We need a way to express dependencies like this between devices.  Or at 
least, there has to be a way to prevent certain devices from resuming 
in parallel.

Alan Stern

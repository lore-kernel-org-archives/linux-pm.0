From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Tue, 23 Dec 2008 21:47:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812232146040.8076-100000__14088.1567415365$1230086991$gmane$org@netrider.rowland.org>
References: <1230086170.562.210.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1230086170.562.210.camel@rzhang-dt>
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
	Jesse" <jesse.barnes@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Dec 2008, Zhang Rui wrote:

> Then I have a question, what if the uchi_hcd is not loaded?
> the ehci host controller doesn't work in this case?

It does work.  But it handles only high-speed devices; low-speed and 
full-speed devices will be ignored (unless they are connected through 
a high-speed hub).

Alan Stern

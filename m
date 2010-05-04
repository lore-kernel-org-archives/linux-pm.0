From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 09:51:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005040949060.1729-100000__14320.8146015697$1272981181$gmane$org@iolanthe.rowland.org>
References: <20100504004338.GA22678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504004338.GA22678@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 May 2010, Matthew Garrett wrote:

> On Mon, May 03, 2010 at 04:37:22PM -0700, Kevin Hilman wrote:
> 
> > Please forgive the ignorance of ACPI (in embedded, we thankfully live
> > in magical world without ACPI) but doesn't that already happen with
> > CPUidle and C-states?  I think of CPUidle as basically runtime PM for
> > the CPU.  IOW, runtime PM manages the devices, CPUidle manages the CPU
> > (via C-states), resulting in dynaimc PM for the entire system.  What
> > am I missing?
> 
> ACPI doesn't provide any functionality for cutting power to most devices 
> other than shifting into full system suspend. The number of wakeup 
> events available to us on a given machine is usually small and the 
> wakeup latency large, so it's not terribly practical to do this 
> transparently on most hardware.

Another thing that Kevin is missing: There is more to the system than
the devices and the CPU.  For example: RAM, an embedded controller (on
modern desktop/laptop systems), a power supply, and so on.  Dynamic PM
for the CPU and the devices won't power-down these things, but system
PM will.

Alan Stern

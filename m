From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 01:43:38 +0100
Message-ID: <20100504004338.GA22678__17449.7370761403$1272933886$gmane$org@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sk68r1zh.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 03, 2010 at 04:37:22PM -0700, Kevin Hilman wrote:

> Please forgive the ignorance of ACPI (in embedded, we thankfully live
> in magical world without ACPI) but doesn't that already happen with
> CPUidle and C-states?  I think of CPUidle as basically runtime PM for
> the CPU.  IOW, runtime PM manages the devices, CPUidle manages the CPU
> (via C-states), resulting in dynaimc PM for the entire system.  What
> am I missing?

ACPI doesn't provide any functionality for cutting power to most devices 
other than shifting into full system suspend. The number of wakeup 
events available to us on a given machine is usually small and the 
wakeup latency large, so it's not terribly practical to do this 
transparently on most hardware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

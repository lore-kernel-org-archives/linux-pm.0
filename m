From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 17:57:48 +0100
Message-ID: <20100526165748.GA7965__3474.56365493617$1274893827$gmane$org@srcf.ucam.org>
References: <20100526160002.GA6242@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005261248060.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005261248060.1328-100000@iolanthe.rowland.org>
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 26, 2010 at 12:56:33PM -0400, Alan Stern wrote:

> I don't know how that works.  However an easy approach would be to make
> opening the device file (or however the userspace driver gets a
> reference to the device) cause the core to do a pm_runtime_get_sync(),
> with a corresponding pm_runtime_put_sync() when the file is closed.

No, X is far worse than you think. It's handled by mmap()ping /dev/mem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

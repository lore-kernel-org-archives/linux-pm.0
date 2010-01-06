From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/12] PCI PM: Make it possible to force using
	INTx for	PCIe PME signaling
Date: Wed, 6 Jan 2010 22:02:14 +0000
Message-ID: <20100106220214.GA25366__44238.3639784113$1262815444$gmane$org@srcf.ucam.org>
References: <200912272057.10443.rjw@sisk.pl> <200912272102.22775.rjw@sisk.pl>
	<20100106135625.14b37f10@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100106135625.14b37f10@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 06, 2010 at 01:56:25PM -0800, Jesse Barnes wrote:

> This scares me a little... seems like we're not restoring some state on
> resume that's needed for MSIs to work?  Looks fine though.

Yeah, that was my concern. We debugged this a little on IRC and didn't 
get anywhere, though, so probably need to find someone who knows more 
about MSIs...

-- 
Matthew Garrett | mjg59@srcf.ucam.org

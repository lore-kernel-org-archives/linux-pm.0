From: Bob Copeland <me@bobcopeland.com>
Subject: Re: [ath5k-devel]  PCI hotplug v.s. suspend
Date: Fri, 19 Jun 2009 07:08:53 -0400
Message-ID: <20090619110853.GA18956__40164.3976606012$1245409870$gmane$org@hash.localnet>
References: <Pine.LNX.4.44L0.0906181437090.3129-100000@netrider.rowland.org>
	<4A3AAF0A.9020707@tuffmail.co.uk> <4A3B4D8C.6010002@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A3B4D8C.6010002@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-pci@vger.kernel.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, ath5k-devel@venema.h4ckr.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 19, 2009 at 09:34:20AM +0100, Alan Jenkins wrote:
> I tried an earlier version without the problem workaround.  Bob's
> suggested patch to remove the free_irq() on suspend works fine.  It
> fixes the WARNING when the device is removed during suspend, and it
> still works if the device is not removed during suspend.

Okay thanks for finding it and testing.  I'll send a version with my
s-o-b later today.

-- 
Bob Copeland %% www.bobcopeland.com

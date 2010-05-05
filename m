From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 19:39:54 +0100
Message-ID: <20100505183954.GF7139__46791.3862471052$1273084896$gmane$org@rakim.wolfsonmicro.main>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005042223.41370.rjw@sisk.pl>
	<20100504235644.GA5231@opensource.wolfsonmicro.com>
	<201005050222.31038.rjw@sisk.pl>
	<20100505110630.GA5754@opensource.wolfsonmicro.com>
	<j2xa55d774e1005050500ocaa77b0di8e9eb58ce9c82d58@mail.gmail.com>
	<20100505135621.GB7139@rakim.wolfsonmicro.main>
	<20100505173337.GA1671@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505173337.GA1671@srcf.ucam.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 06:33:37PM +0100, Matthew Garrett wrote:

> We seem to have ended up managing most of our PM infrastructure 
> iteratively. If the concern is more about best practices than intrinsic 
> incompatibilities, I'd lean towards us being better off merging this now 
> and then working things out over the next few releases as we get a 
> better understanding of the implications. The main thing that we have to 
> get right in the short term is the userspace API - everything else is 
> easier to fix up as we go along.

Right, the big issue for me is that there's likely to be some form of
userspace API visible for controlling this.  I think I can keep it
mostly in-kernel for audio (by providing new APIs to mark some inputs
and outputs as being live during suspend) but need to check.

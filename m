From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
	suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 22:17:39 +0100
Message-ID: <201001252217.39778.rjw__36077.0145467997$1264454318$gmane$org@sisk.pl>
References: <201001240055.59479.rjw@sisk.pl>
	<20100125184350.0fbad233@lxorguk.ukuu.org.uk>
	<20100125104938.6b34d61c@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100125104938.6b34d61c@jbarnes-piketon>
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
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 25 January 2010, Jesse Barnes wrote:
> On Mon, 25 Jan 2010 18:43:50 +0000
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > > This probably belongs in the core DRM KMS code instead of the
> > > driver. I can imagine that there may be some X driver code that
> > > still needs to be executed on suspend/resume for some drivers, so
> > > this may introduce bugs, but it's definitely the right way to go.
> > 
> > You can have a mix of KMS and non KMS consoles active on different
> > cards. So I don't think that is the case.
> 
> I pity users with that configuration.
> 
> But in that case we should be able to disable the VT switch disable
> path; we just have to check each driver as it's loaded.

OK, what the right sequence of checks would be in that case and where to place
them?

Rafael

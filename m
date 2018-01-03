From: Simon Horman <horms@verge.net.au>
Subject: Re: [1/2] arm64: dts: r8a7795: add thermal cooling management
Date: Wed, 3 Jan 2018 11:14:38 +0100
Message-ID: <20180103101438.il5grrfihewiduqe@verge.net.au>
References: <20170913105909.13230-2-niklas.soderlund+renesas@ragnatech.se>
 <20180101181333.GA3631@localhost.localdomain>
 <20180102091944.py647jheghud7sl2@verge.net.au>
 <20180103000352.GB22490@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103000352.GB22490@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 03, 2018 at 01:03:52AM +0100, Niklas Söderlund wrote:
> Hi Simon,
> 
> On 2018-01-02 10:19:44 +0100, Simon Horman wrote:
> > On Mon, Jan 01, 2018 at 10:13:35AM -0800, Eduardo Valentin wrote:
> > > On Wed, Sep 13, 2017 at 12:59:08PM +0200, Niklas Söderlund wrote:
> > > > Add nodes and properties for thermal cooling management support.
> > > > 
> > > > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > > > ---
> > > 
> > > Just a reminder, this series should go via your arch tree. You may add
> > > my acks.
> > 
> > Ack.
> > 
> > Niklas, could you comment on the readiness of these patches
> > for the renesas tree?
> 
> I think maybe the patches might have became a bit outdated since they 
> where posted due to all reg property fixup patches. The blocker for me 
> reposting this series is that the patches this depends 
> 'topic/rcar-gen3-cpufreq' on are not yet in the renesas tree next or 
> devel branches. Do you think it would be valuable for me to refresh 
> these patches before the dependencies are picked up?

Probably not. I'll try to work on getting cpufreq upstream :)

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 0/2] ARM: at91: properly handle LPDDR poweroff
Date: Wed, 12 Oct 2016 13:17:04 +0200
Message-ID: <20161012111704.5mhtu4pjv2vncam5@piout.net>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
 <1791580.DIVsjjyavb@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1791580.DIVsjjyavb@ws-stein>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 10/10/2016 at 08:00:30 +0200, Alexander Stein wrote :
> Hi Alexandre,
> 
> On Friday 07 October 2016 18:34:25, Alexandre Belloni wrote:
> > Hi,
> > 
> > This patch set improves LPDDR support on SoCs using the Atmel MPDDR
> > controller.
> > 
> > LPDDR memoris can only handle up to 400 uncontrolled power offs in their
> > life. The proper power off sequence has to be applied before shutting down
> > the SoC.
> > 
> > I'm not too happy with the code duplication but this is a design choice
> > that has been made before because both shitdown controler are really
>                                          ^^^^^^^^
> 
> I guess you mean shutdown? :) Same for the suject of 2nd patch.
> 

I'm planning to send a v2, hopefully fixing my typos ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

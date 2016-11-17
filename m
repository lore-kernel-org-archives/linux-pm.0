From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/3] thermal: Fix module autoload for drivers
Date: Thu, 17 Nov 2016 06:53:28 -0800
Message-ID: <20161117145327.GA2781@localhost.localdomain>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
 <CABxcv==keE6X5B1R+DSaZewVDdpCtuGF5j4S46YF3pncHT8q2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CABxcv==keE6X5B1R+DSaZewVDdpCtuGF5j4S46YF3pncHT8q2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 17, 2016 at 08:50:11AM -0300, Javier Martinez Canillas wrote:
> Hello Eduardo,
> 
> On Fri, Oct 14, 2016 at 11:34 AM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
> > Hello,
> >
> > This small series contains trivial fixes to allow modules to be autoloaded
> > when its correspoinding thermal device is registered.
> >
> > Best regards,
> > Javier
> >
> >
> > Javier Martinez Canillas (3):
> >   thermal: max77620: Fix module autoload
> >   thermal: tango: Fix module autoload
> >   thermal: db8500: Fix module autoload
> >
> 
> Any comments about these patches?

So far no. I am finalizing a couple of automated testing, but they are
in my queue.

Thanks for the fixes.

BR,

> 
> Best regards,
> Javier

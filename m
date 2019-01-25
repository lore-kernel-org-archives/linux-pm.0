From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: How to remove warn msg "cache: parent cpui should not be
 sleeping" i=1, 2, 3...
Date: Fri, 25 Jan 2019 14:07:01 +0100
Message-ID: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
References: <a793d088-2faf-3ea8-41b6-f0b614a71e19@arm.com>
 <20181002170754.GA10240@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181002170754.GA10240@vmlxhi-102.adit-jv.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-pm@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, Eugeniu Rosca <erosca@de.adit-jv.com>, linux-arm-kernel@lists.infradead.org, Joshua Frkuska <joshua_frkuska@mentor.com>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Tue, Oct 02, 2018 at 07:07:54PM +0200, Eugeniu Rosca wrote:
> Hello Sudeep,
> 
> I too experience the "cache: parent cpuN should not be sleeping" and
> confirm these are healed with your patch. Would it be possible to have
> the patch submitted for review?

Doing some s2ram testing on R-Car H3 Salvator-X using
v5.0-rc3-130-gd73aba1115cf, I am still able to reproduce these warnings.

Is there any chance you push the patch to the mailing list? If not, can
it be taken with a different authorship by mentioning this discussion
thread as source of inspiration?

> Thank you very much,
> Eugeniu.

From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date: Wed, 30 Jan 2019 21:38:40 +0800
Message-ID: <1548855520.2161.3.camel@intel.com>
References: <20190109055724.184692-1-pihsun@chromium.org>
         <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
         <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
         <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
         <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Pi-Hsun Shih <pihsun@chromium.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com
List-Id: linux-pm@vger.kernel.org

On 三, 2019-01-30 at 11:04 +0100, Daniel Lezcano wrote:
> On 30/01/2019 10:25, Pi-Hsun Shih wrote:
> > 
> > On Wed, Jan 30, 2019 at 3:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > 
> > > 
> > > On 30/01/2019 07:04, Peter Shih wrote:
> > > > 
> > > > Adding Michael Kao to cc list.
> > > > 
> > > > On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.or
> > > > g> wrote:
> > > > > 
> > > > > 
> > > > > The mtk_thermal struct contains a 'struct mtk_thermal_bank
> > > > > banks[];',
> > > > > but the allocation only allocates sizeof(struct mtk_thermal)
> > > > > bytes,
> > > > > which cause out of bound access with the ->banks[] member.
> > > > > Change it to
> > > > > a fixed size array instead.
> > > Even if the fix is correct, it pushes back the bug later in time
> > > if a
> > > new board containing more than MAX_NUM_ZONES is introduced. I
> > > suggest to
> > > dynamically allocate the array with the 'num_banks' value.
> > > 
> > For the current code structure, those mtk_thermal_data are
> > statically declared,
> > so if there's new board containing more than MAX_NUM_ZONES of
> > bank_data, it
> > would actually be a compile error.
> > 
> > I'm fine with either way, but feel like that this is simpler than
> > manually
> > calculating the size needed for allocation.
> Right, I missed it can be caught at compile time.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
As this is a bugfix, I will take it and queue it for next -rc.

thanks,
rui
> 
> 

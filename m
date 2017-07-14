From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH 2/4] thermal: imx: Add support for reading OCOTP through
 nvmem
Date: Fri, 14 Jul 2017 13:49:48 +0300
Message-ID: <1500029388.11612.54.camel@nxp.com>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
         <68b476b35b0c0cbce21da0e87338323bb77e9bc4.1499347157.git.leonard.crestez@nxp.com>
         <20170712063629.GD3172@dragon>
         <3dd43cba-02f2-204c-c3a2-582827018ef8@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3dd43cba-02f2-204c-c3a2-582827018ef8-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-07-14 at 09:48 +0100, Srinivas Kandagatla wrote:
> On 12/07/17 07:36, Shawn Guo wrote:

> > > +static int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val)
> > > +{
> > > +	struct nvmem_cell *cell;
> > > +	void *buf;
> > > +	size_t len;
> > > +
> > > +	cell = nvmem_cell_get(dev, cell_id);
> > > +	if (IS_ERR(cell))
> > > +		return PTR_ERR(cell);
> > > +
> > > +	buf = nvmem_cell_read(cell, &len);
> > > +	if (IS_ERR(buf)) {
> > > +		nvmem_cell_put(cell);
> > > +		return PTR_ERR(buf);
> > > +	}
> > > +	if (len != sizeof(*val)) {
> > > +		kfree(buf);
> > > +		nvmem_cell_put(cell);
> > > +		return -EINVAL;
> > > +	}
> > > +	memcpy(val, buf, sizeof(*val));

> This can overflow the memory allocated to val, we should be careful here 
> not to do so.
> limit this to sizeof(u32) should be good. Also add some sanity checks to 
> make sure that len is atleast 4 bytes.

I'm not sure what you mean, isn't this already done? There is an
explicit check above that the read len is exactly as expected. It's
just that the limit is written as sizeof(*val) rather than sizeof(u32).

> > > +
> > > +	kfree(buf);
> > > +	nvmem_cell_put(cell);
> > > +	return 0;
> > > +}
> > The function looks nothing IMX specific, and could be a nvmem core
> > function?
> > 
> > @Srinivas, thoughts?
> Yep, this function looks generic, can be moved to nvmem layer.

Ok, next version of the series will have this function in nvmem core as
a separate commit.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

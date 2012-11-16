From: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 1/3] Runtime Interpreted Power Sequences
Date: Fri, 16 Nov 2012 17:31:04 +0900
Message-ID: <4423025.WvVzNKlS3r@percival>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com> <1353047903-14363-2-git-send-email-acourbot@nvidia.com> <50A5F225.6000200@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A5F225.6000200-qxv4g6HH51o@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "srinivas.kandagatla-qxv4g6HH51o@public.gmane.org" <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Srinivas,

On Friday 16 November 2012 15:58:29 Srinivas KANDAGATLA wrote:
> Hi Alex,
> I am looking forward for this feature to be mainlined,

*cough* Ack *cough* :)

> but I have
> comment on the way the types are tied up to power seq infrastructure.
> I know your use case are limited to using type "delay", "pwm" and "gpio"
> and "regulator", However there are instances where the devices can be
> powered up or reset by writing to special registers or sysconfs or
> something else.
> So My suggestion would be to make these type register them selfs
> dynamically with the power_seq infrastructure so that in future this can
> be extended to other types as-well.
> This trivial change can make a lot of difference for the future chips
> which do thing bit differently.
> ST Microelectronics chips fit it in these category and I guess other
> Vendors have this similar chips.

The current implementation is (purposedly) minimal and will certainly be 
extended. There are other aspects of regulators for instance that should also 
be controllable (voltage comes to mind). And I am totally open to supporting 
new kinds of resources as usage broadens. For this first version I just wanted 
to introduce the feature and minimize the impact should anything (DT 
bindings?) need to change.

I am a little bit skeptical about the purpose of directly accessing registers 
(or any part of the address space) from power sequences. It should at least be 
possible to involve some kind of abstraction. Not necessarily one of the 
currently supported types - but at least something.

The reason is that I'd like to try and avoid direct references to resources 
within sequences as much as possible to make them reusable. If your system has 
two identical devices, you should not need to duplicate their sequences just 
to change a register range from the few steps that make use of it. If you can 
do the same job with, say, a regulator, you can just give it a name, get it at 
runtime using regulator_get() and define it outside of the sequence, in our 
device node.

Of course there might be scenarios where you really need to access a register 
and there is no way to do otherwise, in this case I am open to discussion. But 
before resorting to this I'd like to make that the existing abstraction cannot 
cover the case already.

Alex.

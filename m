From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
Date: Mon, 26 Nov 2018 21:00:23 +0800
Message-ID: <CAEExFWu7rt8oOHFtrvy0h=gwhMaNFXHuaaOxTnLcQfZDXsy9yw@mail.gmail.com>
References: <20181120160530.21015-1-tiny.windzz@gmail.com> <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 12:02 PM Viresh Kumar <viresh.kumar@linaro.org> wro=
te:
>
> On 20-11-18, 11:05, Yangtao Li wrote:
> > The of_find_node_by_path() returns a node pointer with refcount
> > incremented,but there is the lack of use of the of_node_put() when
> > done.Add the missing of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2
> > -update changelog
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh
Hi Gautham=EF=BC=9A

Can you add your Reviewed-by here?

Thanks=EF=BC=8C
Yangtao

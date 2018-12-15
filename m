From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] driver core: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date: Sat, 15 Dec 2018 16:46:18 +0800
Message-ID: <CAEExFWvymtA_-6GWtO5=YpgsbKshQZWs2tgUUh5ZjOoibN-kJA@mail.gmail.com>
References: <20181201015154.4718-1-tiny.windzz@gmail.com> <CAJZ5v0g6R40D-OrQeZ=wAj+epPaYacLTnCVLLHfzUrpNKUv2_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g6R40D-OrQeZ=wAj+epPaYacLTnCVLLHfzUrpNKUv2_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 3, 2018 at 5:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Dec 1, 2018 at 2:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
> > a macro,so remove define_genpd_open_function and define_genpd_debugfs_fops.
> > Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> It would be good at least to split the genpd changes off into a separate patch.
>
> The regmap and comonent changes appear to be independent of each other
> too, so I would put them into separate patches either for easier
> handling.
OK.

MBR,
Yangtao

From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] thermal: qcom-spmi: Delete unused field 'prev_stage'
Date: Wed, 25 Jul 2018 16:25:59 -0700
Message-ID: <CAD=FV=UrbDtXnzvOimAmB8hn-ys3gbv6EHRqCdtbCpXKbFcoHQ@mail.gmail.com>
References: <20180724235636.60357-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724235636.60357-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:56 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The field 'prev_stage' in struct qpnp_tm_chip is not used, remove it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

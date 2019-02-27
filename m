From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
Date: Tue, 26 Feb 2019 16:49:26 -0800
Message-ID: <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
References: <20190221121827.32427-1-rplsssn@codeaurora.org> <20190221121827.32427-3-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221121827.32427-3-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index d6b834eeeb37..9cc303e88a06 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const=
 struct tcs_request *msg)
>         return ret;
>  }
> =20
> +/**
> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
> + *
> + *  @drv: The controller
> + *
> + *  Returns true if the TCSes are engaged in handling requests.
> + */
> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> +{

This API seems inherently racy. How do we know that nothing else is
going to be inserted into the TCS after this function returns true? Do
you have a user of this API? It would be good to know how it is used
instead of adding some code that never gets called.

> +       int m;
> +       struct tcs_group *tcs =3D get_tcs_of_type(drv, ACTIVE_TCS);
> +
> +       spin_lock(&drv->lock);
> +       for (m =3D tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +               if (!tcs_is_free(drv, m)) {
> +                       spin_unlock(&drv->lock);
> +                       return false;
> +               }
> +       }
> +       spin_unlock(&drv->lock);
> +
> +       return true;
> +}
> +
>  /**
>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>   *

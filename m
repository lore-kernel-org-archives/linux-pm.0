From: Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v4 1/2] power_supply: Add more charge types and
 CHARGE_CONTROL_* properties
Date: Thu, 18 Apr 2019 10:45:58 -0600
Message-ID: <CAHX4x85pmo5j1wWLrsNz+nioy-oTwb4NDJcrUKssvdofCmxKug@mail.gmail.com>
References: <20190417004320.232200-1-ncrews@chromium.org> <20190417214022.7jk3usygcpnls3pr@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417214022.7jk3usygcpnls3pr@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Duncan Laurie <dlaurie@chromium.org>, Oleh Lamzin <lamzin@google.com>, Bartosz Fabianowski <bartfab@google.com>, Daniel Erat <derat@google.com>, Dmitry Torokhov <dtor@google.com>, Simon Glass <sjg@chromium.org>, jchwong@chromium.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 3:40 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> The changes itself look all good to me, but this does multiple
> things in a single patch, so please split it into multiple commits.

Thanks Sebastian!

I split this into 3 commits:
-add more charge_type's
-add more CHARGE_CONTROL_* properties
-Add missing documentation for other CHARGE_CONTROL_* properties

and just re-sent them.

>
> -- Sebastian
>

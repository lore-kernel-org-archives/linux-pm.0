From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/4] power: bq25890_charger.c: Add debugging output of
 failed initialization
Date: Thu, 26 Jul 2018 08:44:17 +0200
Message-ID: <CAJKOXPdJZU38CHkM-3zEtBpA92supwVcj4z_kEF5XMxOj3_TKg@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-2-angus@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725194630.10414-2-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> To ease adding a new part variant some debugging is handy
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/4] power: bq25890_charger.c: Remove unused table entries
Date: Tue, 31 Jul 2018 18:58:34 +0200
Message-ID: <CAJKOXPemYmGykswET2C-v7A-edb4zODq7XRJUL-qkKFf1tvvMg@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-3-angus@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731164316.32696-3-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> There are a few table entries that aren't used. Drop them.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

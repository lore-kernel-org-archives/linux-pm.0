From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] smartreflex: Neaten logging
Date: Fri, 12 Aug 2016 07:46:30 -0500
Message-ID: <ef0d3152-a01a-9359-bfb5-3fb8ab1b6041@ti.com>
References: <8dd34715bc267a29cade4ceec193ca1066f18db4.1470986036.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8dd34715bc267a29cade4ceec193ca1066f18db4.1470986036.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/12/2016 02:14 AM, Joe Perches wrote:
> Use a more common logging style.
>
> Miscellanea:
>
> o Use pr_warn
> o Coalesce formats adding missing spaces
> o Argument alignment
> o Remove unnecessary OOM messages as k.alloc does stack dumps
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Nishanth Menon <nm@ti.com>

Kevin, would you be able to pick this up?

-- 
Regards,
Nishanth Menon

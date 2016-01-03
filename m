From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PowerCap: constify powercap_zone_ops and powercap_zone_constraint_ops structures
Date: Sun, 03 Jan 2016 01:58:18 +0100
Message-ID: <2776851.fyhdtS7sMd@vostro.rjw.lan>
References: <1450907995-825-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1450907995-825-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 23, 2015 10:59:55 PM Julia Lawall wrote:
> The powercap_zone_ops and powercap_zone_constraint_ops structures are never
> modified, so declare them as const.
> 
> Most of the actual changes adjust indentation to accomodate the const
> keyword.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks!


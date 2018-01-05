From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 12/12] power: reset: account for const type of
 of_device_id.data
Date: Fri, 5 Jan 2018 14:24:56 +0100
Message-ID: <20180105132456.GD2614@piout.net>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, kernel-janitors@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/01/2018 at 14:28:08 +0100, Julia Lawall wrote:
> This driver creates a const structure that it stores in the data
> field of an of_device_id array.
> 
> Add const to the declaration of the location that receives a value
> from the data field to ensure that the compiler will continue to check
> that the value is not modified and remove the const-dropping cast on
> the access to the data field.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

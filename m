From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 1/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Mon, 09 Nov 2015 08:58:39 +0900
Message-ID: <563FE1AF.3040305@samsung.com>
References: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
 <1447014418-27849-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1447014418-27849-2-git-send-email-mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09.11.2015 05:26, Matt Ranostay wrote:
> Add runtime PM support for the lidar-lite module to enable low power
> mode when last device requested reading is over a second.
> 
> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof

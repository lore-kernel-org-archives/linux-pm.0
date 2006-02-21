From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/4] [pm] Add state filed to pm_message_t (to
	hold actual state device is in).
Date: Tue, 21 Feb 2006 09:50:43 -0800
Message-ID: <20060221175043.GB23054@kroah.com>
References: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80666175039573718=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, linux-pm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============80666175039573718==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2006 at 04:55:37PM -0800, Patrick Mochel wrote:
> 
> Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
> 
> ---
> 
>  include/linux/pm.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> applies-to: 55ce8c6305fc70b1b544ce7365abd6054e9b5f61
> 7af37561812f4599841ade4abee067b808b40054
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 5be87ba..a7324ea 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -140,6 +140,7 @@ struct device;
> 
>  typedef struct pm_message {
>  	int event;
> +	u32 state;

Can we _please_ make this an enumerated type that is able to be
type-checked by sparse?  A "raw" u32 is not a good thing to have here.

thanks,

greg k-h

--===============80666175039573718==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80666175039573718==--

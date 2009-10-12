From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PM / Hibernate: fix error handling in
	save_image
Date: Mon, 12 Oct 2009 23:29:30 +0200
Message-ID: <4AD39FBA.6000509@gmail.com>
References: <1255175505-7756-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255175505-7756-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/10/2009 01:51 PM, Jiri Slaby wrote:
> +	if (!ret)
>  		printk("\b\b\b\bdone\n");
> +	else
> +		printk("\n");

Only the hell knows why I didn't post a similar fix for load_image...
Will do now.

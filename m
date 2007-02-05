From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] windfarm: dont die on suspend thread
	signal
Date: Mon, 5 Feb 2007 23:43:25 +0100
Message-ID: <20070205224325.GA8453@lst.de>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070205185835.700233000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 05, 2007 at 07:30:29PM +0100, Johannes Berg wrote:
> -		/* there should be no signal, but oh well */
> -		if (signal_pending(current)) {
> +		/* there should be no non-suspend signal, but oh well */
> +		if (signal_pending(current) && !try_to_freeze()) {

Given that the driver uses the kthread infrastructure and doesn't
explicitly re-enable signals there can't be any other signal.
So just remove the signal_pending check.

From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 5/5] [pci pm] Make pci_choose_state() use the
	real device state requested
Date: Sat, 18 Feb 2006 16:58:36 +0100
Message-ID: <20060218155836.GF5658@openzaurus.ucw.cz>
References: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============068650209021188235=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
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
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============068650209021188235==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

>  	case PM_EVENT_FREEZE:
>  	case PM_EVENT_SUSPEND:
> -		return PCI_D3hot;
> +		if (msg.state && msg.state <= PCI_D3hot)
> +			state = msg.state;
> +		break;
>  	default:

Silently ignores wrong value passed-in by user. Not nice...
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============068650209021188235==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============068650209021188235==--

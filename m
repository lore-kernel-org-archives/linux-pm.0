From: David Rientjes <rientjes@google.com>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Fri, 9 Mar 2007 13:27:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091326270.13252@chino.kir.corp.google.com>
References: <20070305181826.GA21515@linux.intel.com>
	<Pine.LNX.4.64.0703051941310.18703@chino.kir.corp.google.com>
	<20070306164722.GB22725@linux.intel.com>
	<Pine.LNX.4.64.0703061838390.13314@chino.kir.corp.google.com>
	<20070309205344.GA16777@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070309205344.GA16777@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-mm@kvack.org, mark.gross@intel.com, linux-pm@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, neelam.chandwani@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 9 Mar 2007, Mark Gross wrote:

> +int __nearest_non_pm_node(int nid)
> +{
> +	int i, dist, closest, temp;
> +	=

> +	if (!__power_managed_node(nid))
> +		return nid;
> +	dist =3D closest=3D 255;
> +	for_each_node(i) {

Shouldn't this be for_each_online_node(i) ?

> +		if (__power_managed_node(i))
> +			continue;
> +
> +		if (i !=3D nid) {
> +			temp =3D __node_distance(nid, i );
> +			if (temp < dist) {
> +				closest =3D i;
> +				dist =3D temp;
> +			}
> +		}
> +	}
> +	BUG_ON(closest =3D=3D 255);
> +	return closest;
> +}

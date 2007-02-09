From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: question on freeze and aio
Date: Sat, 10 Feb 2007 08:29:36 +1100
Message-ID: <1171056576.1484.41.camel@nigel.suspend2.net>
References: <200702091704.30770.oliver@neukum.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702091704.30770.oliver@neukum.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Fri, 2007-02-09 at 17:04 +0100, Oliver Neukum wrote:
> Hi,
> =

> can there be running aio requests if all tasks are frozen?

Since tasks are frozen, no new aio requests would be submitted. We do a
sync to ssek to complete existing requests; I haven't looked to see
whether that would need extending to flush aio as well, but don't think
that would be the case. Given everyone else's silence, so far, you might
be better to ask the author(s) of the aio code.

(As I type Rafael's reply has arrived, but I think my answer might still
be helpful, so I'll send it too).

Regards,

Nigel

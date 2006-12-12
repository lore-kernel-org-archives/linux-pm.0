From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 2/3] windfarm: dont die on suspend thread signal
Date: Tue, 12 Dec 2006 13:10:01 +0000
Message-ID: <20061212131000.GC5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<20061211230754.679589000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061211230754.679589000@sipsolutions.net>
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
Cc: linuxppc-dev@ozlabs.org, Michael Hanselmann <linux-kernel@hansmi.ch>, Torrance <torrance123@gmail.com>, Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue 12-12-06 00:02:10, Johannes Berg wrote:
> When the windfarm thread gets a suspend signal it will die instead of
> freezing. This fixes it.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

ACK.

-- =

Thanks for all the (sleeping) penguins.

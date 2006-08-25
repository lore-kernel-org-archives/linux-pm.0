From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Voltage/power domain framework?
Date: Fri, 25 Aug 2006 11:00:17 -0700
Message-ID: <20060825180017.GA7636@linux.intel.com>
References: <mailman.2682.1156469445.1142.linux-pm@lists.osdl.org>
	<002101c6c81b$2c61ffd0$4686190c@dsn.sec.samsung.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <002101c6c81b$2c61ffd0$4686190c@dsn.sec.samsung.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <ikhwan.lee@samsung.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 25, 2006 at 04:50:42PM +0900, Ikhwan Lee wrote:
> I've seen quite a few discussions mentioning the necessity of voltage/pow=
er
> domain framework. Is there any project going on? I heard that there were
> some activities by Nokia, but I could not find any on the web.
> =


There isn't anything formal going on.  However; there is a loose
collection of folks working on the "operating point" patches with an eye
to defining a lower level interface to enable voltage/power/clock domain
framework's.  =


This activity is fall out from last April's PM-summit
http://lwn.net/Articles/181888/, one can also infer the interested
parties from the mail activity on this list.

Do you have some design ideas, patches,  or requirements in this area that =
could be
taken into account?

--mgross

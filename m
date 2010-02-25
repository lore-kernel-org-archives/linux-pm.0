From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Thu, 25 Feb 2010 18:32:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002251831450.1383-100000@iolanthe.rowland.org>
References: <4B86FE66.7000901@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B86FE66.7000901@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Feb 2010, =C1kos Mar=F3y wrote:

> my dmesg is much more talkative - please find it attached.

Remember, both suspend and hibernate are certain to fail unless you =

rmmod xhci-hcd first.

Alan Stern

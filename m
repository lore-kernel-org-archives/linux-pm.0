From: akuster <akuster@mvista.com>
Subject: Re: [PATCH 1/2] PM: fast power off - core
Date: Sat, 27 Jan 2007 12:34:42 -1000
Message-ID: <45BBD382.1030607@mvista.com>
References: <45BBA9D5.8020004@mvista.com>
	<20070127120821.a631acd6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070127120821.a631acd6.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel-owner@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Andrew,

Andrew Morton wrote:
> On Sat, 27 Jan 2007 09:36:53 -1000
> akuster <akuster@mvista.com> wrote:
> =

>> Fastpoweroff  allows a user to power down the system without using rc ki=
ll
>> scripts. =

> =

> Confused. =


I have a knack of doing that.

  I just type `halt -pfn'.

Thats fine but from what I can tell, it does not try to remount the file =

system before powering off.

  Why is this patch better?

It allows the user to configure how a power off sequence is defined =

beyond the "Halt" via inserting a new profile module. In the default,
processes are frozen and the file system is remounted as read only.

- Armin

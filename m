From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 12:08:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707231205500.3828__12743.2581656196$1185218000$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707231408.32051.rjw@sisk.pl>
	<E1ICwoE-0004q8-00@dorka.pomaz.szeredi.hu>
	<200707231431.30372.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1671903907-1185217688=:3828"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707231431.30372.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1671903907-1185217688=:3828
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp2.linux-foundation.org id l6NJBjwC018568

On Mon, 23 Jul 2007, Oliver Neukum wrote:

> Am Montag 23 Juli 2007 schrieb Miklos Szeredi:
>>> The reason is that we want them to "park" in safe places, ie. where t=
here
>>> are no locks held etc. =C2=A0Thus, these safe places need to be chose=
n somehow
>>> and since they are not marked throughout the code, we choose the obvi=
ous
>>> one. :-)
>>
>> Why shouldn't locks be held?
>>
>> No locks which are required for suspend must be held, sure. =C2=A0But
>> otherwise holding locks doesn't matter at all.
>
> If you can provide a way to tell them apart, this would work.

can you just tell the driver to try and suspend and if it reports back=20
that it fails back out of the suspend? or will the driver deadlock instea=
d=20
of reporting a failure if a lock is held.

David Lang
--680960-1671903907-1185217688=:3828
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1671903907-1185217688=:3828--

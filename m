From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/9] PM: Add suspend block api.
Date: Fri, 23 Apr 2010 19:15:59 -0700
Message-ID: <p2vd6200be21004231915o5b2d4ed1zbabd3e51e6213f45__21606.000691145$1272075541$gmane$org@mail.gmail.com>
References: <1271984938-13920-2-git-send-email-arve@android.com>
	<Pine.LNX.4.44L0.1004231204450.1777-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004231204450.1777-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/23 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 22 Apr 2010, [UTF-8] Arve Hj=F8nnev=E5g wrote:
...
>> +Calling suspend_block when the suspend blocker is active or suspend_unb=
lock when
>> +it is not active has no effect. This allows drivers to update their sta=
te and
>> +call suspend suspend_block or suspend_unblock based on the result.
>
> But suspend_block() and suspend_unblock() don't nest. =A0You should
> mention this.
>

I'm not sure what you mean by this? I think the first sentence
dictates nesting is not supported.

I think the rest of your comments will be addressed in the next
version of the document, that I worked with Rafael on.

-- =

Arve Hj=F8nnev=E5g

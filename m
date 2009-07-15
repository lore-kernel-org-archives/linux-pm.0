From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Wed, 15 Jul 2009 12:41:33 +0200
Message-ID: <87ocrm6xeq.fsf__5935.66983375258$1247654566$gmane$org@basil.nowhere.org>
References: <1247643512.26272.74.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247643512.26272.74.camel@rzhang-dt> (Zhang Rui's message of
	"Wed, 15 Jul 2009 15:38:32 +0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:
>
> Currently, in order to make sure that it won't bring any side effects,
> I only convert the ACPI battery and i8042 to use this framework, which re=
duces
> 0.5s+ S3 time(suspend time plus resume time)=EF=BB=BF, from 7.0s to less =
than 6.5s.

10.5s+ was intended I guess?

-Andi

-- =

ak@linux.intel.com -- Speaking for myself only.

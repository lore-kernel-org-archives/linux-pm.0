From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH RESEND] tools: add power/x86/turbostat - v2
Date: Mon, 15 Nov 2010 15:16:47 -0200
Message-ID: <AANLkTi=FK0em5qYV0wf_SMpbC_SrOYYB0i0w1L5WS+Ec__9226.8810178668$1289922492$gmane$org@mail.gmail.com>
References: <alpine.LFD.2.00.1010230116590.29399@localhost.localdomain>
	<alpine.LFD.2.00.1010240004180.23060@localhost.localdomain>
	<alpine.LFD.2.00.1010262312090.3209@localhost.localdomain>
	<alpine.LFD.2.00.1011151056380.2939@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1011151056380.2939@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 15, 2010 at 2:01 PM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> turbostat displays actual processor frequency on modern
> Intel processors. =A0Note that this capability depends on free-running
> APERF and MPERF MSRs, which were cleared by the acpi_cpufreq
> driver up through Linux-2.6.29.
>
> On Intel Core i3/i5/i7 (Nehalem) and newer processors,
> turbostat displays residency in idle power saving states.
>
> See the comments in the source code for example usage.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Reviewed-by: Otavio Salvador

Reviewed-by: Otavio Salvador <otavio@ossystems.com.br>

-- =

Otavio Salvador=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O.S. Systems
E-mail: otavio@ossystems.com.br=A0 http://www.ossystems.com.br
Mobile: +55 53 9981-7854=A0 =A0 =A0 =A0=A0 http://projetos.ossystems.com.br

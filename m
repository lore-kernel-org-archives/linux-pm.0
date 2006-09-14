From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: OpPoint summary
Date: Thu, 14 Sep 2006 10:25:41 -0700
Message-ID: <45099095.3020303@intel.com>
References: <20060911082025.GD1898@elf.ucw.cz>	
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>	
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>	
	<20060911225617.GB13474@elf.ucw.cz>	
	<20060912001701.GC14234@linux.intel.com>	
	<20060912033700.GD27397@kroah.com>	
	<b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>	
	<20060914055529.GA18031@kroah.com>
	<b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

David Singleton wrote:

> +static const struct cpu_id cpu_ids[] =3D {
> +       [CPU_BANIAS]    =3D { 6,  9, 5 },
> +       [CPU_DOTHAN_A1] =3D { 6, 13, 1 },
> +       [CPU_DOTHAN_A2] =3D { 6, 13, 2 },
> +       [CPU_DOTHAN_B0] =3D { 6, 13, 6 },
> +       [CPU_MP4HT_D0]  =3D {15,  3, 4 },
> +       [CPU_MP4HT_E0]  =3D {15,  4, 1 },
> +};


Any reason why { 6, 13, 8 } is missing? My lenovo T43 identifies itself as =
such:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8

I'm not sure a Dothan B1 exists, but some postings suggest even C0 and C1 a=
re =

valid steppings. I'm sure OpPoint could work with those as well.

Auke

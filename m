From: "David Singleton" <daviado@gmail.com>
Subject: Re: OpPoint summary
Date: Thu, 14 Sep 2006 11:17:40 -0700
Message-ID: <b324b5ad0609141117p5e67633o776871f80f2529c2@mail.gmail.com>
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
	 <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
	 <45099095.3020303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750886AbWINSRm@vger.kernel.org>
In-Reply-To: <45099095.3020303@intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9/14/06, Auke Kok <auke-jan.h.kok@intel.com> wrote:
> David Singleton wrote:
>
> > +static const struct cpu_id cpu_ids[] = {
> > +       [CPU_BANIAS]    = { 6,  9, 5 },
> > +       [CPU_DOTHAN_A1] = { 6, 13, 1 },
> > +       [CPU_DOTHAN_A2] = { 6, 13, 2 },
> > +       [CPU_DOTHAN_B0] = { 6, 13, 6 },
> > +       [CPU_MP4HT_D0]  = {15,  3, 4 },
> > +       [CPU_MP4HT_E0]  = {15,  4, 1 },
> > +};
>
>
> Any reason why { 6, 13, 8 } is missing? My lenovo T43 identifies itself as such:
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 13
> model name      : Intel(R) Pentium(R) M processor 1.86GHz
> stepping        : 8
>
> I'm not sure a Dothan B1 exists, but some postings suggest even C0 and C1 are
> valid steppings. I'm sure OpPoint could work with those as well.

Yes it could.  The centrino was the first platform I tested on and I used the
existing speedstep-centrino code from cpufreq.  The 1.86Ghz  was not in
the cpufreq base.    But you can see how easy it is to add new operating points
for a new cpu.

Adding new platform support is quite straight forward.  It basically requires
a function to transition to the new operating point and the parameters needed
for the transition.

David
>
> Auke
>

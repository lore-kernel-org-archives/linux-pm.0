From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: intel-pstate driver not clocking down on Atom Z8750
Date: Sun, 25 Jun 2017 17:27:59 -0700
Message-ID: <1498436879.4671.22.camel@linux.intel.com>
References: <13898444.q12oX9ZNe5@aspire.rjw.lan>
         <CAAYJcCWViZ0DTj6e9XxN1xkiBR5CAbFA6R73jg=o8d2J6Z2raA@mail.gmail.com>
         <CAAYJcCXPUE78PBN_njrnHseBUOPXsek48ac4RGh5Jx_mgvYpKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wO36Z6Kx7MDbTGysOpDE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbdFZA2B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Jun 2017 20:28:01 -0400
In-Reply-To: <CAAYJcCXPUE78PBN_njrnHseBUOPXsek48ac4RGh5Jx_mgvYpKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christopher Williamson <home@chrisaw.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>


--=-wO36Z6Kx7MDbTGysOpDE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2017-06-25 at 18:37 -0400, Christopher Williamson wrote:
> 4.8 and 4.12-rc6
> 
I just gave a quick test on a HP Cherrytrail laptop with 4.12 tip.
Attached is the output, which show that this does scale.
It is possible that you don't have any idle (C-states) or some task is
keeping system busy.

I suggest:
1. Run turbostat and attach output.
2. Attach output of tools/power/x86/intel_pstate_tracer for a minute
run.

Thanks,
Srinivas

> On Jun 25, 2017 at 10:24 PM, "Rafael J. Wysocki" <rjw@rjwysocki.net>
> wrote: 
> > On Sunday, June 25, 2017 03:39:11 PM Christopher Williamson wrote:
> > > Hi there,
> > >
> > > I've just purchased a device called a "GPD Pocket" (more info at
> > > indiegogo.com/projects/gpd-pocket-7-0-umpc-laptop-ubuntu-or-win-
> > 10-os-laptop--2/x/7959405)
> > > but in short - one of the major problems I have with the device
> > is that the
> > > included Intel Atom Z8750 never clocks below the turbo boost
> > speed meaning
> > > it overheats very quickly and crashes.
> > >
> > > I have managed to avoid this behaviour in two ways:
> > >
> > > 1.) Disable turbo boost - the device then sits firmly at 1.6GHz
> > and refuses
> > > to clock below that.
> > >
> > > 2.) Disable the intel_pstate driver and the CPU then clocks
> > properly but
> > > cannot turbo boost at all so I lose that capability.
> > >
> > > I'm really just reaching out to you fine folks to find out where
> > best to
> > > discuss this issue. I'm happy to raise a kernel bug report if
> > that helps
> > > and also happy to provide command outputs as needed.
> > >
> > > I have included Hans de Goede in the CC list on this email since
> > he has
> > > been a great help getting to this point - this device has a few
> > strange
> > > quirks to work through but this is a fairly serious one.
> > 
> > What kernel versions have you tried?
> > 
> > Thanks,
> > Rafael
> > 
> > 
> > 
--=-wO36Z6Kx7MDbTGysOpDE
Content-Disposition: attachment; filename="cht_turbostat.txt"
Content-Type: text/plain; name="cht_turbostat.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

W3Rlc3R1c2VyQG90Y3BsLWhwLWNodC1mZWRvcmEgdHVyYm9zdGF0XSQgc3VkbyB0dXJib3N0YXQg
LS1zaG93IENvcmUsQ1BVLEF2Z19NSHosQnVzeSUsQnp5X01IeixUU0NfTUh6CnR1cmJvc3RhdCB2
ZXJzaW9uIDE3LjA0LjEyIC0gTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+CkNQVUlEKDApOiBH
ZW51aW5lSW50ZWwgMTEgQ1BVSUQgbGV2ZWxzOyBmYW1pbHk6bW9kZWw6c3RlcHBpbmcgMHg2OjRj
OjMgKDY6NzY6MykKQ1BVSUQoMSk6IFNTRTMgTU9OSVRPUiAtIEVJU1QgVE0yIFRTQyBNU1IgQUNQ
SS1UTSBUTQpDUFVJRCg2KTogQVBFUkYsIFRVUkJPLCBEVFMsIE5vLVBUTSwgTm8tSFdQLCBOby1I
V1Bub3RpZnksIE5vLUhXUHdpbmRvdywgTm8tSFdQZXBwLCBOby1IV1Bwa2csIEVQQgpjcHUzOiBN
U1JfSUEzMl9NSVNDX0VOQUJMRTogMHgwMDg1MDA4OSAoVENDIEVJU1QgTm8tTVdBSVQgUFJFRkVU
Q0ggVFVSQk8pCkNQVUlEKDcpOiBOby1TR1gKY3B1MzogTVNSX1BMQVRGT1JNX0lORk86IDB4NjAw
MDYwMDE0MDAKNiAqIDEzMy4zID0gODAwLjAgTUh6IG1heCBlZmZpY2llbmN5IGZyZXF1ZW5jeQoy
MCAqIDEzMy4zID0gMjY2Ni42IE1IeiBiYXNlIGZyZXF1ZW5jeQpjcHUzOiBNU1JfSUEzMl9QT1dF
Ul9DVEw6IDB4MDAwMDAwMDAgKEMxRSBhdXRvLXByb21vdGlvbjogRElTYWJsZWQpCmNwdTM6IE1T
Ul9UVVJCT19SQVRJT19MSU1JVDogMHgwMDAwMDAwMApjcHUzOiBNU1JfUEtHX0NTVF9DT05GSUdf
Q09OVFJPTDogMHgwMDA2MDAwZiAoVU5sb2NrZWQ6IHBrZy1jc3RhdGUtbGltaXQ9MTU6IHVua25v
d24pCmNwdTM6IGNwdWZyZXEgZHJpdmVyOiBpbnRlbF9wc3RhdGUKY3B1MzogY3B1ZnJlcSBnb3Zl
cm5vcjogcG93ZXJzYXZlCmNwdWZyZXEgaW50ZWxfcHN0YXRlIG5vX3R1cmJvOiAwCmNwdTA6IE1T
Ul9JQTMyX0VORVJHWV9QRVJGX0JJQVM6IDB4MDAwMDAwMDYgKGJhbGFuY2VkKQpjcHUwOiBNU1Jf
SUEzMl9URU1QRVJBVFVSRV9UQVJHRVQ6IDB4MDM1YTAwMDAgKDkwIEMpCkNvcmUJQ1BVCUF2Z19N
SHoJQnVzeSUJQnp5X01IeglUU0NfTUh6Ci0JLQk2CTEuMDQJOTI1CTE2MDAKMAkwCTgJMS40Nwk5
MTMJMTYwMAoxCTEJOAkxLjM5CTk1MQkxNjAwCjIJMgkyCTAuMzQJODU2CTE2MDAKMwkzCTUJMC45
Nwk5MjgJMTYwMApDb3JlCUNQVQlBdmdfTUh6CUJ1c3klCUJ6eV9NSHoJVFNDX01IegotCS0JNwkx
LjExCTExMDkJMTYwMAowCTAJMTUJMi4xMgkxMjE3CTE2MDAKMQkxCTEyCTEuOTEJMTA1NQkxNjAw
CjIJMgkxCTAuMTIJODAwCTE2MDAKMwkzCTEJMC4zMAk4MDAJMTYwMApDb3JlCUNQVQlBdmdfTUh6
CUJ1c3klCUJ6eV9NSHoJVFNDX01IegotCS0JMwkwLjUzCTk2NAkxNjAwCjAJMAk3CTEuMTMJMTAw
NgkxNjAwCjEJMQkzCTAuNDYJMTA0OQkxNjAwCjIJMgkwCTAuMTAJODAwCTE2MDAKMwkzCTIJMC40
Mwk4MDAJMTYwMApDb3JlCUNQVQlBdmdfTUh6CUJ1c3klCUJ6eV9NSHoJVFNDX01IegotCS0JNgkx
LjA2CTk2NAkxNjAwCjAJMAkxMQkxLjk2CTk1NAkxNjAwCjEJMQk5CTEuMzgJMTAzNQkxNjAwCjIJ
MgkxCTAuMjcJODg0CTE2MDAKMwkzCTMJMC42MQk4NzMJMTYwMApDb3JlCUNQVQlBdmdfTUh6CUJ1
c3klCUJ6eV9NSHoJVFNDX01IegotCS0JMjEJMi4wMwkxNzE3CTE2MDAKMAkwCTIyCTIuODgJMTI5
NQkxNjAwCjEJMQkzNAkyLjgxCTE5OTUJMTYwMAoyCTIJMTMJMS4wOAkyMDI1CTE2MDAKMwkzCTE0
CTEuMzQJMTc5OAkxNjAwCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6Ci0J
LQk4OAk4LjE2CTE4MDAJMTYwMAowCTAJNzUJOS42NAkxMjk2CTE2MDAKMQkxCTc2CTcuODYJMTYx
NwkxNjAwCjIJMgkxMDAJNy41MwkyMjE3CTE2MDAKMwkzCTEwMQk3LjYxCTIyMTYJMTYwMApDb3Jl
CUNQVQlBdmdfTUh6CUJ1c3klCUJ6eV9NSHoJVFNDX01IegotCS0JMTA1CTguNDQJMjA2OAkxNjAw
CjAJMAkyMjgJMTUuNTAJMjQ1MQkxNjAwCjEJMQkxNTEJMTIuMjEJMjA2NwkxNjAwCjIJMgkxMwky
LjI5CTk1NQkxNjAwCjMJMwkyNgkzLjc0CTExNTgJMTYwMApDb3JlCUNQVQlBdmdfTUh6CUJ1c3kl
CUJ6eV9NSHoJVFNDX01IegotCS0JNDE1CTI1LjM0CTI3MzAJMTYwMAowCTAJMzg4CTIyLjg0CTI4
MzIJMTYwMAoxCTEJNTc1CTMzLjkzCTI4MjMJMTYwMAoyCTIJNDM4CTI2LjI3CTI3ODEJMTYwMAoz
CTMJMjU5CTE4LjMzCTIzNTkJMTYwMApDb3JlCUNQVQlBdmdfTUh6CUJ1c3klCUJ6eV9NSHoJVFND
X01IegotCS0JMzgJNC4zOAkxNDQxCTE2MDAKMAkwCTY5CTcuMDcJMTYzMQkxNjAwCjEJMQk0MQk0
LjU4CTE0NzkJMTYwMAoyCTIJMzYJNC44NQkxMjQyCTE2MDAKMwkzCTUJMS4wMQk4OTYJMTYwMApD
b3JlCUNQVQlBdmdfTUh6CUJ1c3klCUJ6eV9NSHoJVFNDX01IegotCS0JMTQJMS4yMQkxODU0CTE2
MDAKMAkwCTgJMS4xMgkxMjQ2CTE2MDAKMQkxCTE0CTEuMTYJMjA1MgkxNjAwCjIJMgkyMAkxLjUy
CTIxNzkJMTYwMAozCTMJMTIJMS4wNwkxODE2CTE2MDAKQ29yZQlDUFUJQXZnX01IeglCdXN5JQlC
enlfTUh6CVRTQ19NSHoKLQktCTIxCTMuMTMJMTExNgkxNjAwCjAJMAkxOAkyLjUxCTEyMjEJMTYw
MAoxCTEJNAkwLjY1CTExMDUJMTYwMAoyCTIJMjAJMy4zOAkxMDA3CTE2MDAKMwkzCTQxCTUuOTkJ
MTEzNAkxNjAwCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6Ci0JLQkyMzIJ
MTcuNDgJMjIxMgkxNjAwCjAJMAkyNDUJMTguODUJMjE2NgkxNjAwCjEJMQkxNjMJMTMuMjkJMjA0
MAkxNjAwCjIJMgkyNzAJMTkuNTEJMjMwNQkxNjAwCjMJMwkyNTAJMTguMjYJMjI4NAkxNjAwCkNv
cmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6Ci0JLQk2Nwk3LjA1CTE1ODIJMTYw
MAowCTAJNzEJOC45MwkxMzMzCTE2MDAKMQkxCTQ5CTQuMDEJMjAyNAkxNjAwCjIJMgk5Mwk4LjU3
CTE4MDcJMTYwMAozCTMJNTUJNi42OQkxMzY0CTE2MDAKQ29yZQlDUFUJQXZnX01IeglCdXN5JQlC
enlfTUh6CVRTQ19NSHoKLQktCTI0CTMuNzAJMTA3MgkxNjAwCjAJMAkzMwk1LjcyCTk2MAkxNjAw
CjEJMQkxNQkyLjc1CTg5MQkxNjAwCjIJMgkyNAkzLjQ2CTExNTIJMTYwMAozCTMJMjQJMi44Nwkx
Mzc0CTE2MDAKCg==


--=-wO36Z6Kx7MDbTGysOpDE--

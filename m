From: Pintu Kumar <pintu.ping@gmail.com>
Subject: Not able to set smp_affinity for an IRQ on i.MX7
Date: Fri, 11 May 2018 17:04:50 +0530
Message-ID: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2595804741952351622=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernelnewbies@kernelnewbies.org
List-Id: linux-pm@vger.kernel.org

--===============2595804741952351622==
Content-Type: multipart/alternative; boundary="00000000000024d142056bec86f6"

--00000000000024d142056bec86f6
Content-Type: text/plain; charset="UTF-8"

Hi,

I need one help.
I am using i.MX7 Sabre board with kernel version 4.1.15

Let's say I am interested in GPIO number: 21
I wanted to set CPU affinity for particular GPIO->IRQ number, so I tried
the below steps:
root@10:~# echo 21 > /sys/class/gpio/export
root@10:~# echo "rising" > /sys/class/gpio/gpio21/edge
root@10:~# cat /proc/interrupts | grep 21
  47: 0 0 gpio-mxc 21 Edge gpiolib
root@10:~# cat /sys/class/gpio/gpio21/direction
in
root@10:~# cat /proc/irq/47/smp_affinity
3
root@10:~# echo 2 > /proc/irq/47/smp_affinity
-bash: echo: write error: Input/output error

But I get input/output error.
When I debug further, found that irq_can_set_affinity is returning 0:
[    0.000000] genirq: irq_can_set_affinity (0): balance: 1, irq_data.chip:
a81b7e48, irq_set_affinity:   (null)
[    0.000000] write_irq_affinity: FAIL

I also tried first setting /proc/irq/default_smp_affinity to 2 (from 3).
This change is working, but the smp_affinity setting for the new IRQ is not
working.

When I try to set smp_affinity for mmc0, then it works.
# cat /proc/interrupts | grep mmc
295:         55          0     GPCV2  22 Edge      mmc0
296:          0          0     GPCV2  23 Edge      mmc1
297:         52          0     GPCV2  24 Edge      mmc2

root@10:~# echo 2 > /proc/irq/295/smp_affinity
root@10:~#


So, I wanted to know what are the conditions for which setting smp_affinity
for an IRQ will work ?

Is there any way by which I can set CPU affinity to a GPIO -> IRQ ?
Whether, irq_set_affinity_hint() will work in this case ?


Thanks,
Pintu

--00000000000024d142056bec86f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif">I need one help.</div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif">I am using i.MX7 Sabre board with ker=
nel version 4.1.15</div><div class=3D"gmail_default" style=3D"font-family:v=
erdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:verdana,sans-serif">Let&#39;s say I am interested in GPIO number: 21</d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">I =
wanted to set CPU affinity for particular GPIO-&gt;IRQ number, so I tried t=
he below steps:</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><span style=3D"font-family:arial,sans-serif">root@10:~# ech=
o 21 &gt; /sys/class/gpio/export</span></div><div class=3D"gmail_default" s=
tyle=3D"font-family:verdana,sans-serif"><span style=3D"font-family:arial,sa=
ns-serif">root@10:~# echo &quot;rising&quot; &gt; /sys/class/gpio/gpio21/ed=
ge</span></div><div class=3D"gmail_default" style=3D"font-family:verdana,sa=
ns-serif"><span style=3D"font-family:arial,sans-serif">root@10:~# cat /proc=
/interrupts | grep 21</span></div><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif"><span style=3D"font-family:arial,sans-serif">=
=C2=A0 47:          0          0  gpio-mxc  21 Edge      gpiolib</span></di=
v><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><sp=
an style=3D"font-family:arial,sans-serif">root@10:~# cat /sys/class/gpio/gp=
io21/direction</span></div><div class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif"><span style=3D"font-family:arial,sans-serif">in</span=
></div><div class=3D"gmail_default"><span style=3D"font-family:verdana,sans=
-serif">root@10:~# cat /proc/irq/47/smp_affinity</span></div><div class=3D"=
gmail_default"><span style=3D"font-family:verdana,sans-serif">3</span></div=
><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">

<div class=3D"gmail_default">root@10:~# echo 2 &gt; /proc/irq/47/smp_affini=
ty</div><div class=3D"gmail_default">-bash: echo: write error: Input/output=
 error</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defa=
ult">But I get input/output error.</div><div class=3D"gmail_default">When I=
 debug further, found that irq_can_set_affinity is returning 0:</div><div c=
lass=3D"gmail_default"><div class=3D"gmail_default">[=C2=A0 =C2=A0 0.000000=
] genirq: irq_can_set_affinity (0): balance: 1, irq_data.chip: a81b7e48, ir=
q_set_affinity:=C2=A0 =C2=A0(null)</div><div class=3D"gmail_default">[=C2=
=A0 =C2=A0 0.000000] write_irq_affinity: FAIL</div><div class=3D"gmail_defa=
ult"><br></div><div class=3D"gmail_default">I also tried first setting=C2=
=A0/proc/irq/default_smp_affinity to 2 (from 3).</div><div class=3D"gmail_d=
efault">This change is working, but the smp_affinity setting for the new IR=
Q is not working.</div><div class=3D"gmail_default"><br></div><div class=3D=
"gmail_default">When I try to set smp_affinity for mmc0, then it works.</di=
v><div class=3D"gmail_default"># cat /proc/interrupts | grep mmc</div><div =
class=3D"gmail_default"><div class=3D"gmail_default">295:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A055=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0=
GPCV2=C2=A0 22 Edge=C2=A0 =C2=A0 =C2=A0 mmc0</div><div class=3D"gmail_defau=
lt">296:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0=C2=A0 =C2=A0 =C2=A0GPCV2=C2=A0 23 Edge=C2=A0 =C2=A0 =C2=A0 mmc1</div>=
<div class=3D"gmail_default">297:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A052=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0GPCV2=C2=A0 24 Edge=C2=A0=
 =C2=A0 =C2=A0 mmc2</div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default"><div class=3D"gmail_default">root@10:~# echo 2 &gt; /pro=
c/irq/295/smp_affinity</div><div class=3D"gmail_default">root@10:~#</div></=
div></div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defaul=
t"><br></div><div class=3D"gmail_default">So, I wanted to know what are the=
 conditions for which setting smp_affinity for an IRQ will work ?</div><div=
 class=3D"gmail_default"><br></div><div class=3D"gmail_default">Is there an=
y way by which I can set CPU affinity to a GPIO -&gt; IRQ ?</div><div class=
=3D"gmail_default">Whether, irq_set_affinity_hint() will work in this case =
?</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default">=
<br></div><div class=3D"gmail_default">Thanks,</div><div class=3D"gmail_def=
ault">Pintu</div><div class=3D"gmail_default"><br></div></div></div></div>

--00000000000024d142056bec86f6--


--===============2595804741952351622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============2595804741952351622==--

From: Romano Giannetti <romanol@upcomillas.es>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 09:37:04 +0200
Message-ID: <1183448224.12649.14.camel__10902.1251941615$1183450878$gmane$org@localhost>
References: <20070703042916.GA17240@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703042916.GA17240@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> or alternatively we  could do what we do for suspend to RAM on other
> platforms (PPC and APM) and just not use the freezer.

As a data point, I am running with this patch on top of 2.6.21.2 the
last 3+ weeks, with an average of 5/6 STR cycles a day, and had no
problems at all. (Sony vaio pcg-fx701). Just normal work, I didn't try
to stress the thing, but I have quite a few times suspended/resumed over
a big compile without a glitch.

What are the risks of this patch supposed to be?

Romano



--
La presente comunicaci=C3=B3n tiene car=C3=A1cter confidencial y es para =
el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el d=
estinatario indicado, le informamos que cualquier forma de distribuci=C3=B3=
n, reproducci=C3=B3n o uso de esta comunicaci=C3=B3n y/o de la informaci=C3=
=B3n contenida en la misma est=C3=A1n estrictamente prohibidos por la ley=
. Si Ud. ha recibido esta comunicaci=C3=B3n por error, por favor, notif=C3=
=ADquelo inmediatamente al remitente contestando a este mensaje y proceda=
 a continuaci=C3=B3n a destruirlo. Gracias por su colaboraci=C3=B3n.

This communication contains confidential information. It is for the exclu=
sive use of the intended addressee. If you are not the intended addressee=
, please note that any form of distribution, copying or use of this commu=
nication or the information in it is strictly prohibited by law. If you h=
ave received this communication in error, please immediately notify the s=
ender by reply e-mail and destroy this message. Thank you for your cooper=
ation.

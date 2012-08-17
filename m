From: karan patil <kkarrann011@gmail.com>
Subject: Hibernate-Snapshot device
Date: Fri, 17 Aug 2012 01:45:25 -0700
Message-ID: <CAN7pkvka9N3DKMd4Zuqu2mWK93TDQ5OkFg5gkm7JBZiTEBb59g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=bcaec550aea861a27904c7722e66
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--bcaec550aea861a27904c7722e66
Content-Type: text/plain; charset=ISO-8859-1

I would like to know how the snapshot of the system is taken during
hibernation(S2disk) which is then stored in the swap partition.
A typical /etc/suspend.conf shows that the snapshot device to be used is
set to /dev/snapshot. Please suggest something to make my understanding
better as to  how the snaphot image is created and exactly how it is stored
at its position which is then loaded into memory on resume(resume device
parameter embedded into initramfs).

--bcaec550aea861a27904c7722e66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I would like to know how the snapshot of the system is taken during hiberna=
tion(S2disk) which is then stored in the swap partition.<br>A typical /etc/=
suspend.conf shows that the snapshot device to be used is set to /dev/snaps=
hot. Please suggest something to make my understanding better as to=A0 how =
the snaphot image is created and exactly how it is stored at its position w=
hich is then loaded into memory on resume(resume device parameter embedded =
into initramfs).<br>

--bcaec550aea861a27904c7722e66--
